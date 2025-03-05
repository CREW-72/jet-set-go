const { onRequest } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");
const { initializeApp } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");
const axios = require("axios");

// Initialize Firebase Admin SDK
initializeApp();
const db = getFirestore();

// Define Secret (Fetch from Firebase Secrets)
const FLIGHTAWARE_API_KEY = defineSecret("FLIGHTAWARE_API_KEY");

// Cloud Function to Fetch Flight Data
exports.getFlightDetails = onRequest({ secrets: [FLIGHTAWARE_API_KEY] }, async (req, res) => {
  try {
    const { flightNumber } = req.query;
    if (!flightNumber) {
      return res.status(400).json({ error: "Flight number is required" });
    }

    // Check if data is cached in Firestore
    const cachedFlight = await db.collection("flights").doc(flightNumber).get();
    if (cachedFlight.exists) {
      return res.status(200).json(cachedFlight.data());
    }

    // Fetch flight details from FlightAware AeroAPI
    const apiUrl = `https://aeroapi.flightaware.com/aeroapi/flights/${flightNumber}`;
    const response = await axios.get(apiUrl, {
      headers: { "x-apikey": FLIGHTAWARE_API_KEY.value() }, // Fetch secret value
    });

    if (response.status !== 200) {
      return res.status(response.status).json({ error: "Failed to fetch flight data" });
    }

    // Format flight data
    const flightData = response.data.flights[0];
    const formattedData = {
          flightNumber: flightData.ident || "N/A",
          airline: flightData.operator_iata || "Unknown",
          origin: {
            code: flightData.origin.code_iata || "N/A",
            name: flightData.origin.name || "N/A",
            city: flightData.origin.city || "N/A",
            terminal: flightData.terminal_origin || "N/A",
            gate: flightData.gate_origin || "N/A",
          },
          destination: {
            code: flightData.destination.code_iata || "N/A",
            name: flightData.destination.name || "N/A",
            city: flightData.destination.city || "N/A",
            terminal: flightData.terminal_destination || "N/A",
            gate: flightData.gate_destination || "N/A",
          },
          status: flightData.status || "Unknown",
          scheduledDeparture: flightData.scheduled_out || "N/A",
          estimatedDeparture: flightData.estimated_out || "N/A",
          actualDeparture: flightData.actual_out || "N/A",
          scheduledArrival: flightData.scheduled_in || "N/A",
          estimatedArrival: flightData.estimated_in || "N/A",
          actualArrival: flightData.actual_in || "N/A",
          aircraft: {
            model: flightData.aircraft_type || "Unknown",
            registration: flightData.registration || "N/A",
          },
          lastUpdated: new Date().toISOString(),
        };

    // Store in Firestore for caching
    await db.collection("flights").doc(flightNumber).set(formattedData);

    res.set("Cache-Control", "public, max-age=300, s-maxage=600"); // Cache headers
    res.status(200).json(formattedData);
  } catch (error) {
    console.error("Error fetching flight data:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
