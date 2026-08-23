import { StrictMode, useEffect } from 'react';
import { createRoot } from 'react-dom/client';
import App from './App';
import './index.css';

function applyCefTransparency() {
  const targets = [document.documentElement, document.body, document.getElementById('root')];

  for (const el of targets) {
    if (!el) continue;
    el.style.setProperty('background', 'transparent', 'important');
    el.style.setProperty('background-color', 'rgba(0, 0, 0, 0)', 'important');
  }

  document.documentElement.style.setProperty('color-scheme', 'normal', 'important');
}

function Root() {
  useEffect(() => {
    applyCefTransparency();
    const observer = new MutationObserver(applyCefTransparency);
    observer.observe(document.documentElement, { attributes: true, attributeFilter: ['style', 'class'] });
    return () => observer.disconnect();
  }, []);

  return <App />;
}

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <Root />
  </StrictMode>,
);
