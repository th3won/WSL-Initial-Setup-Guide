
import React, { useState } from 'react';
import { ChecklistItemType } from './types';
import Step from './components/Step';
import ChecklistItem from './components/ChecklistItem';
// FIX: Import the CodeBlock component to display code snippets.
import CodeBlock from './components/CodeBlock';

const initialChecklistItems: ChecklistItemType[] = [
  { id: 1, label: 'WSL 설치 및 재부팅', completed: false },
  { id: 2, label: 'Ubuntu 사용자 계정 생성', completed: false },
  { id: 3, label: 'VS Code 설치 (Windows)', completed: false },
  { id: 4, label: 'WSL 확장 설치', completed: false },
  { id: 5, label: 'WSL에서 `code .` 실행 확인', completed: false },
  { id: 6, label: '클로드 확장 설치', completed: false },
  { id: 7, label: '추가 도구 설치 (강사 지시에 따라)', completed: false },
];


const App: React.FC = () => {
  const [checklistItems, setChecklistItems] = useState<ChecklistItemType[]>(initialChecklistItems);

  const handleToggleChecklist = (id: number) => {
    setChecklistItems(prevItems =>
      prevItems.map(item =>
        item.id === id ? { ...item, completed: !item.completed } : item
      )
    );
  };

  return (
    <div className="min-h-screen bg-gray-900 font-sans text-gray-200 p-4 sm:p-6 lg:p-8">
      <main className="max-w-4xl mx-auto">
        <header className="text-center mb-12">
          <h1 className="text-4xl sm:text-5xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-sky-400 to-cyan-300 pb-2">
            WSL 환경 초기 설정 가이드
          </h1>
          <p className="text-lg text-gray-400">(간략판)</p>
        </header>

        <Step stepNumber={1} title="WSL 설치" duration="5분">
          <p>PowerShell을 관리자 권한으로 실행합니다.</p>
          {/* FIX: Replaced invalid `code.text` component with `CodeBlock` and corrected prop `text` to `code`. */}
          <CodeBlock code={`wsl --install`} language="powershell" />
          <p className="font-bold text-amber-400">**완료 후 재부팅 필수**</p>
        </Step>

        <Step stepNumber={2} title="WSL 초기 설정">
          <p>재부팅 후 자동으로 Ubuntu 터미널이 실행됩니다. 아래 정보를 입력해주세요.</p>
          <ul className="list-disc list-inside">
            <li>사용자 이름 입력</li>
            <li>비밀번호 설정 (2번 입력, 화면에 표시되지 않음)</li>
          </ul>
        </Step>

        <Step stepNumber={3} title="WSL 업데이트">
          <p>WSL 터미널에서 다음 명령어를 실행하여 패키지를 최신 상태로 업데이트합니다.</p>
          {/* FIX: Replaced invalid `code.text` component with `CodeBlock` and corrected prop `text` to `code`. */}
          <CodeBlock code={`sudo apt update && sudo apt upgrade -y`} language="bash" />
        </Step>

        <Step stepNumber={4} title="Visual Studio Code 설치">
          <h3 className="text-lg font-semibold text-gray-100">Windows에 VS Code 설치</h3>
          <p>
            <a href="https://code.visualstudio.com/" target="_blank" rel="noopener noreferrer" className="text-sky-400 hover:text-sky-300 underline">https://code.visualstudio.com/</a> 에서 다운로드합니다.
          </p>
          <p>설치 시 <strong className="text-amber-400">"PATH에 추가"</strong> 옵션을 반드시 체크해야 합니다.</p>
          <h3 className="text-lg font-semibold text-gray-100 mt-4">VS Code에서 WSL 확장 설치</h3>
          <ol className="list-decimal list-inside">
            <li>VS Code 실행</li>
            <li>Extensions (단축키: <kbd className="px-2 py-1.5 text-xs font-semibold text-gray-800 bg-gray-100 border border-gray-200 rounded-lg">Ctrl</kbd>+<kbd className="px-2 py-1.5 text-xs font-semibold text-gray-800 bg-gray-100 border border-gray-200 rounded-lg">Shift</kbd>+<kbd className="px-2 py-1.5 text-xs font-semibold text-gray-800 bg-gray-100 border border-gray-200 rounded-lg">X</kbd>)</li>
            <li>"WSL" 검색 → Microsoft의 WSL 확장 설치</li>
          </ol>
        </Step>

        <Step stepNumber={5} title="WSL에서 VS Code 실행">
          <p>WSL 터미널에서 아래 명령어를 실행하면 현재 디렉토리를 VS Code에서 엽니다.</p>
          {/* FIX: Replaced invalid `code.text` component with `CodeBlock` and corrected prop `text` to `code`. */}
          <CodeBlock code={`code .`} language="bash" />
          <p>처음 실행 시 필요한 VS Code Server가 WSL 내에 자동으로 설치됩니다.</p>
        </Step>

        <Step stepNumber={6} title="클로드 확장 설치">
          <p>VS Code의 Extensions 탭에서 다음 중 하나를 선택하여 설치합니다.</p>
          <h3 className="text-lg font-semibold text-gray-100 mt-4">옵션 A: GitHub Copilot (추천)</h3>
          <ul className="list-disc list-inside">
              <li>"GitHub Copilot" 검색 및 설치</li>
              <li>GitHub 계정과 연동하면 Claude 모델을 사용할 수 있습니다.</li>
          </ul>
           <h3 className="text-lg font-semibold text-gray-100 mt-4">옵션 B: Claude Dev</h3>
          <ul className="list-disc list-inside">
              <li>"Claude Dev" 검색 및 설치</li>
              <li>Anthropic API 키를 입력해야 합니다.</li>
          </ul>
        </Step>
        
        <Step stepNumber={7} title="기본 개발 도구 설치" duration="필요시">
          <p>필요에 따라 Node.js, Python, Git 등의 개발 도구를 설치합니다.</p>
          {/* FIX: Replaced invalid `code.text` component with `CodeBlock` and corrected prop `text` to `code`. */}
          <CodeBlock code={`# Node.js
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Python
sudo apt install -y python3 python3-pip

# Git
sudo apt install -y git`} language="bash" />
          <p className="mt-4 font-semibold">설치 확인 방법:</p>
          {/* FIX: Replaced invalid `code.text` component with `CodeBlock` and corrected prop `text` to `code`. */}
          <CodeBlock code={`code --version    # VS Code 연동 확인
node --version    # Node.js 확인 (설치한 경우)
python3 --version # Python 확인 (설치한 경우)`} language="bash" />
        </Step>

        <section className="mt-12 p-6 bg-gray-800/50 rounded-xl border border-gray-700">
           <h2 className="text-2xl font-bold text-green-400 mb-4">🎯 빠른 체크리스트</h2>
           <div className="space-y-2">
            {checklistItems.map(item => (
                <ChecklistItem key={item.id} item={item} onToggle={handleToggleChecklist} />
            ))}
           </div>
        </section>

      </main>
    </div>
  );
};

export default App;
