
import React from 'react';
import { ChecklistItemType } from '../types';
import CheckIcon from './icons/CheckIcon';

interface ChecklistItemProps {
  item: ChecklistItemType;
  onToggle: (id: number) => void;
}

const ChecklistItem: React.FC<ChecklistItemProps> = ({ item, onToggle }) => {
  return (
    <label
      className={`flex items-center p-3 rounded-md cursor-pointer transition-all duration-200 ${
        item.completed ? 'bg-green-500/20 text-gray-300' : 'bg-gray-700/50 hover:bg-gray-700'
      }`}
    >
      <input
        type="checkbox"
        checked={item.completed}
        onChange={() => onToggle(item.id)}
        className="sr-only"
      />
      <div
        className={`w-6 h-6 flex-shrink-0 rounded border-2 flex items-center justify-center mr-4 transition-all duration-200 ${
          item.completed ? 'bg-green-500 border-green-400' : 'bg-gray-800 border-gray-600'
        }`}
      >
        {item.completed && <CheckIcon className="w-5 h-5 text-white" />}
      </div>
      <span className={`flex-grow ${item.completed ? 'line-through text-gray-400' : ''}`}>
        {item.label}
      </span>
    </label>
  );
};

export default ChecklistItem;
