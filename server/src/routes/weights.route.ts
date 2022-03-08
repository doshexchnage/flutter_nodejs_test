import { Router } from 'express';
import { AuthCheck } from '../middlewares';
import { IUser } from '../models';

import {
  AddUserWeights,
  DeleteUserWeights,
  EditUserWeights,
  GetWeightsWhere,
} from '../services';

const router = Router();

router.get('/', async (req: any, res) => {
  res.send('Welcome 🔥');
});

router.get('/get_weight_history', AuthCheck, async (req: any, res) => {
  const response = await GetWeightsWhere(req?.user!);
  res.send(response);
});

router.post('/save_weight', AuthCheck, async (req: any, res) => {
  const response = await AddUserWeights(req.user! as IUser, req.body);
  res.send(response);
});

router.put('/edit_weight/:id', AuthCheck, async (req: any, res) => {
  const response = await EditUserWeights(
    req.params.id,
    req.body,
    (<any>req).user! as IUser
  );
  res.send(response);
});

router.delete('/delete_weight/:id', AuthCheck, async (req: any, res) => {
  const response = await DeleteUserWeights(
    req.params.id,
    (<any>req).user! as IUser
  );
  res.send(response);
});

export default router;
