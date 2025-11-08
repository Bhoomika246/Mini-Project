import express from "express";
import mongoose from "mongoose";
import cors from "cors";

const app = express();
app.use(cors());
app.use(express.json());

// test route
app.get("/", (req, res) => {
  res.send("Server is running 🚜🌾");
});

// Connect to MongoDB (replace URI with yours)
mongoose.connect("mongodb://127.0.0.1:27017/agriRent", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log("✅ Connected to MongoDB"))
.catch((err) => console.log("❌ MongoDB connection failed:", err));

const PORT = 5000;
app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
