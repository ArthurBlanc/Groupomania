// Import "express" package - Fast, unopinionated, minimalist web framework
const express = require("express");
// Import "cors" package - Node.js CORS middleware
const cors = require("cors");
// Import "body-parser" package - Node.js body parsing middleware
const bodyParser = require("body-parser");
// Security packages
// Import "helmet" package - Helmet helps secure Express apps by setting various HTTP headers (add 11 security middlewares)
const helmet = require("helmet");
// Import "limiter" middleware - Basic IP rate-limiting middleware. Use to limit repeated requests to public APIs and/or endpoints (Brute force)
const limiter = require("./middleware/limiter");

// Import "post" route
const postRoutes = require("./routes/post");
// Import "thumb" route
const thumbRoutes = require("./routes/thumb");
// Import "user" route
const userRoutes = require("./routes/user");
// Import "comment" route
const commentRoutes = require("./routes/comment");

const app = express();

app.use(cors());

app.use(helmet());
app.use("/api/auth", limiter);

app.use(bodyParser.json());

app.use("/api/auth", userRoutes);
app.use("/api/posts", postRoutes);
app.use("/api/comments", commentRoutes);
app.use("/api/thumbs", thumbRoutes);

module.exports = app;
