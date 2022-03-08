import { nanoid } from 'nanoid';
import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router';

import { Row } from './../components/Row';
import {
  DeleteAsync,
  EditAsync,
  formatDate,
  GetAsync,
  persistToken,
  PostAsync,
} from '../helpers';

import { IWeight } from '../models/weight.model';
import EditorDialog from './EditorDialog';
import NavBar from '../components/NavBar';
import Footer from '../components/Footer';

const DEFAULT_WEIGHT = {
  value: 0,
  timestamp: '',
};

export default function Dashboard() {
  const [weight, setWeight] = useState<IWeight | null>(null);
  const [weights, setWeights] = useState<IWeight[]>([]);
  const [editMode, setEditMode] = useState<boolean>(false);

  //#region Handle Data Transcations
  const GetData = async () => {
    GetAsync('/weights/get_weight_history').then(async (res) => {
      const data = await res.json();

      setWeights(data);
    });
  };

  const handleEdit = (weight: IWeight) => async (e: any) => {
    setWeight(weight);
    setEditMode(true);

    await EditAsync('/weights/edit_weight/' + weight.uid, weight);
    await GetData();
  };

  const handleDelete = (weight: IWeight) => async (e: any) => {
    const confirmed = window.confirm('Confirm to Delete');
    if (!confirmed) return;

    await DeleteAsync('/weights/delete_weight/' + weight.uid);
    await GetData();
  };

  const saveData = async (data: IWeight) => {
    if (editMode) {
      await EditAsync('/weights/edit_weight/' + data.uid, data);
      setWeight(null);
      setEditMode(false);
      return;
    }

    await PostAsync('/weights/save_weight', data);
    setWeight(null);
  };

  //#endregion Handle Data Transcations

  useEffect(() => {
    GetData();
  }, [weight]);

  return (
    <>
      <main>
        <NavBar createClick={() => setWeight(DEFAULT_WEIGHT)} />
        <ul className="list">
          {weights.map((weight) => (
            <Row
              key={nanoid()}
              handleEdit={handleEdit}
              handleDelete={handleDelete}
              weight={weight}
            />
          ))}
        </ul>
        <Footer />
      </main>

      <EditorDialog
        open={!!weight}
        data={weight}
        saveData={saveData}
        close={() => setWeight(null)}
      />
    </>
  );
}
