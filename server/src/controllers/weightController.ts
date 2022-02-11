
import { Request, Response } from "express";
import { IWeight, WeightEntry } from "../models/weightEntry";

export class WeightController {

    public async getWeightHistory (req: Request, res: Response): Promise<void> {

        WeightEntry.find({userID : req.query.userID}).sort({created_date: 'desc'}).exec((err, weights) => {
            if(err) {
                res.json({status: 'error', err});
            }
            else {
                res.json({status: 'ok', message: weights});
            }
        });

    }

    public async addWeightEntry(req: Request, res: Response): Promise<void> {
        const newWeight: IWeight = new WeightEntry(req.body);

        newWeight.save((err, weight) => {
            if(err){
                res.json({status: 'error', err});
            }
            else if (!weight) {
                res.json({status: 'display-error', error: 'Unable to save weight entry'});
            }
            else {
                res.json({status: 'ok', message: weight});
            }
        });
        
    }

    public async updateWeightEntry (req: Request, res: Response): Promise<void> {
        
        WeightEntry.findOneAndUpdate({ _id: req.body._id}, req.body, {new:true}, (err, weight) => {
            if(err){
                res.json({status: 'error', err});
            }
            else {
                res.json({status: 'ok', message: weight});
            }            
        });
    }

    public async deleteWeightEntry (req: Request, res: Response): Promise<void> {
        WeightEntry.findOneAndDelete({ _id: req.body._id}, (err, result) => {
            if(err){
                res.json({status: 'error', err});
            }
            else if (!result) {
                res.json({status: 'display-error', error: 'Unable to remove weight entry'});
            }
            else {
                res.json({status: 'ok', message: 'Successfully removed weight entry!'});
            }
            
            
        });
    }
}