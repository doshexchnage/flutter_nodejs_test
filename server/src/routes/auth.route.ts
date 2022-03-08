import { Router } from 'express';
import { IAuthPayload } from '../interfaces';
import { AuthCheck } from '../middlewares';
import { GetUsers, Login, PurgeUsers, Register } from '../services';

const router = Router();

router.post('/login', async (req, res, next) => {
  const payload: IAuthPayload = req.body;

  const response = await Login(payload);

  res.send(response);
});

router.post('/sign_up', async (req, res, next) => {
  const payload: IAuthPayload = req.body;

  const response = await Register(payload);

  res.json(response);
});

router.get('/all_users', AuthCheck, async (req, res, next) => {
  const payload: IAuthPayload = req.body;

  try {
    const response = await GetUsers(payload);
    res.send(response);
  } catch (error) {
    next(error);
  }
});

router.purge('/all_users', async (req, res, next) => {
  const payload: IAuthPayload = req.body;

  const response = await PurgeUsers(payload);

  res.send(response);
});

export default router;
