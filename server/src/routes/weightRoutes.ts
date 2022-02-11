import { Router } from "express";
import { WeightController } from "../controllers/weightController";
import { verifyToken } from "../controllers/tokenUtils";


export class WeightRoutes {

    public router: Router;
    public weightController: WeightController = new WeightController();

    private WEIGHT_ROUTES = {
        SAVE_WEIGHT: '/save_weight',
        UPDATE_WEIGHT: '/update_weight',
        DELETE_WEIGHT: '/delete_weight',
        GET_WEIGHT_HISTORY: '/get_weight_history'
    }

    constructor() {
        this.router = Router();
        this.routes();
    }

    routes() {
        this.router.use(verifyToken);
        this.router.post(this.WEIGHT_ROUTES.SAVE_WEIGHT, this.weightController.addWeightEntry);        
        this.router.get(this.WEIGHT_ROUTES.GET_WEIGHT_HISTORY, this.weightController.getWeightHistory);
        this.router.put(this.WEIGHT_ROUTES.UPDATE_WEIGHT, this.weightController.updateWeightEntry); 
        this.router.post(this.WEIGHT_ROUTES.DELETE_WEIGHT, this.weightController.deleteWeightEntry);
    }
}