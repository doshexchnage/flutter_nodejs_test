import React, { useEffect, useState } from 'react';
import { IWeight } from '../models/weight.model';
import { FormEvent } from '../types';

export default function EditorDialog(props: EditorDailogProps) {
  const [weight, setWeight] = useState<IWeight>();

  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();

    if (!weight) return;

    console.log(weight.value);

    props.saveData(weight!);
  };

  useEffect(() => {
    setWeight({ ...props.data! });
    // console.log(props);

    return () => {
      setWeight(undefined);
    };
  }, [props]);

  return (
    <>
      {props.open && <div className="backdrop" onClick={props.close}></div>}
      <dialog open={props.open}>
        <div className="message">
          <span>
            {' '}
            Please enter a <strong>Weight</strong>
          </span>
          {props.data?.timestamp && (
            <code>
              {'<'}EDIT MODE{'>'}
            </code>
          )}
        </div>
        <form onSubmit={handleSubmit}>
          <input
            type="number"
            placeholder="Your Weight (kg)"
            min={2}
            onChange={(e) =>
              setWeight({
                ...weight,
                value: +e.target.value,
                timestamp: new Date().toISOString(),
              })
            }
            value={weight?.value || ''}
          />
          <button type="submit">Save Weight</button>
        </form>
      </dialog>
    </>
  );
}

interface EditorDailogProps {
  open: boolean;
  close: () => void;
  saveData: (data: IWeight) => any;
  data: IWeight | null;
}
