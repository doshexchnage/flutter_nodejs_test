const { Router } = require("express");
const signUpController = require("../controllers/signUp");
const loginController = require("../controllers/login");
const logoutController = require("../controllers/logout");
const saveWeightController = require("../controllers/saveWeight");
const updateWeightController = require("../controllers/updateWeight");
const getWeightHistoryController = require("../controllers/getWeightHistory");
const deleteWeightHistoryController = require("../controllers/deleteWeight");

const route = Router();

route.post("/signUp", signUpController.signUp);
route.post("/login", loginController.login);
route.get("/logout", logoutController.logout);
route.post("/weight", saveWeightController.saveWeight);
route.put("/weight/:id", updateWeightController.updateWeight);
route.get("/weight", getWeightHistoryController.getWeightHistory);
route.delete("/weight/:id", deleteWeightHistoryController.deleteWeight);

module.exports = route;
