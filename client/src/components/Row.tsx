import React from 'react';
import { formatDate } from '../helpers';
import { IWeight } from '../models/weight.model';

type func = (args: any) => any;

interface RowProps {
  handleEdit: func;
  handleDelete: func;
  weight: IWeight;
}

export function Row(props: RowProps) {
  return (
    <li className="list__item">
      <div className="text">
        <span className="value">{props.weight.value} KG</span>
        <span className="subtext">{formatDate(props.weight.timestamp)}</span>
      </div>
      <div className="actions">
        <div
          title="edit"
          onClick={props.handleEdit(props.weight)}
          className="action"
        >
          ✒️
        </div>
        <div
          title="delete"
          onClick={props.handleDelete(props.weight)}
          className="action"
        >
          🔥
        </div>
      </div>
    </li>
  );
}
