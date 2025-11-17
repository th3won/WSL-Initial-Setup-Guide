
import React from 'react';
import CodeBlock from './CodeBlock';

interface StepProps {
  stepNumber: number;
  title: string;
  duration?: string;
  children: React.ReactNode;
  code?: {
    text: string;
    language: string;
  };
}

const Step: React.FC<StepProps> = ({ stepNumber, title, duration, children, code }) => {
  return (
    <section className="mb-10 p-6 bg-gray-800/50 rounded-xl border border-gray-700 backdrop-blur-sm shadow-lg">
      <div className="flex items-baseline gap-4 mb-3">
        <span className="flex items-center justify-center w-10 h-10 bg-sky-500/20 text-sky-400 font-bold text-lg rounded-full shrink-0">
          {stepNumber}
        </span>
        <h2 className="text-2xl font-bold text-sky-400">
          {title}
          {duration && <span className="text-sm font-normal text-gray-400 ml-2">({duration})</span>}
        </h2>
      </div>
      <div className="pl-14 text-gray-300 space-y-3 prose prose-invert max-w-none prose-p:my-2 prose-ul:my-2 prose-li:my-1">
        {children}
        {code && <CodeBlock code={code.text} language={code.language} />}
      </div>
    </section>
  );
};

export default Step;
