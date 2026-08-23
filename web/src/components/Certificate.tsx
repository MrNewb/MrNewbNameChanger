import { useCallback, useEffect, useState } from 'react';
import paperBackground from '../assets/paper.webp';
import { fetchNui, postNui } from '../utils/nui';
import type { CertificateOpenPayload } from '../types/certificate';
import './certificate.css';

type CertificateProps = {
  payload: CertificateOpenPayload;
  onClose: () => void;
};

function isLettersOnly(value: string) {
  return /^[A-Za-z]+$/.test(value);
}

export function Certificate({ payload, onClose }: CertificateProps) {
  const { allowConfirm, allowInput, maxLength, issuedDate, certificateNo, labels, inputLabels } = payload;
  const [firstName, setFirstName] = useState(payload.firstName ?? '');
  const [lastName, setLastName] = useState(payload.lastName ?? '');
  const [nameError, setNameError] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [closing, setClosing] = useState(false);
  const [stamping, setStamping] = useState(false);

  const trimmedFirst = firstName.trim();
  const trimmedLast = lastName.trim();
  const legalName = `${trimmedFirst} ${trimmedLast}`.trim();
  const canConfirm = !allowInput || (trimmedFirst.length > 0 && trimmedLast.length > 0);

  const closeOverlay = useCallback(() => {
    if (closing) return;
    setClosing(true);
    const reduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    window.setTimeout(() => onClose(), reduced ? 0 : 180);
  }, [closing, onClose]);

  const dismiss = useCallback(() => {
    if (submitting || closing) return;
    postNui('certificateResult', { confirmed: false });
    closeOverlay();
  }, [closeOverlay, closing, submitting]);

  const fileCertificate = async () => {
    if (!allowConfirm || !canConfirm || submitting || closing) return;

    if (allowInput && (!isLettersOnly(trimmedFirst) || !isLettersOnly(trimmedLast))) {
      setNameError(labels.invalidName);
      return;
    }

    setSubmitting(true);
    setStamping(true);
    try {
      const result = await fetchNui<{ ok?: boolean }>(
        'certificateResult',
        { confirmed: true, firstName: trimmedFirst, lastName: trimmedLast },
        { ok: true },
      );
      if (result.ok === false) {
        setNameError(labels.invalidName);
        setSubmitting(false);
        setStamping(false);
        return;
      }
      closeOverlay();
    } catch {
      setNameError(labels.invalidName);
      setSubmitting(false);
      setStamping(false);
    }
  };

  useEffect(() => {
    postNui('certificateReady');
  }, []);

  useEffect(() => {
    setFirstName(payload.firstName ?? '');
    setLastName(payload.lastName ?? '');
    setNameError('');
  }, [payload.firstName, payload.lastName]);

  useEffect(() => {
    const onKeyDown = (event: globalThis.KeyboardEvent) => {
      if (event.key !== 'Escape') return;
      event.preventDefault();
      dismiss();
    };

    window.addEventListener('keydown', onKeyDown);
    return () => window.removeEventListener('keydown', onKeyDown);
  }, [dismiss]);

  return (
    <div className={`certificate-app${closing ? ' certificate-app--closing' : ''}`}>
      <div className="certificate-veil" aria-hidden="true" />

      <div className="paper-shell paper-shell--form">
        <div className="paper-container">
          <img
            className="paper-background"
            src={paperBackground}
            alt=""
            decoding="async"
            fetchPriority="high"
            draggable={false}
          />
          <div className="paper-grain-overlay" aria-hidden="true" />
          <div className="paper-fiber-overlay" aria-hidden="true" />
          <div className="paper-vignette" aria-hidden="true" />

          <form
            className="certificate-sheet"
            role="dialog"
            aria-modal="true"
            aria-labelledby="certificate-title"
            aria-describedby={nameError ? 'certificate-error' : allowInput ? 'certificate-hint' : undefined}
            onSubmit={(event) => {
              event.preventDefault();
              void fileCertificate();
            }}
          >
            <header className="certificate-header">
              <p className="certificate-issuer">{labels.issuer}</p>
              <p className="certificate-subtitle">{labels.subtitle}</p>
              <h1 id="certificate-title" className="certificate-title">
                {labels.title}
              </h1>
            </header>

            <section className="certificate-body">
              <p className="certificate-lead">{labels.lead}</p>

              {allowInput && inputLabels ? (
                <div className={`certificate-inputs${nameError ? ' certificate-inputs--error' : ''}`}>
                  <label className="certificate-input">
                    <span className="certificate-input__label">{inputLabels.firstName}</span>
                    <input
                      className="certificate-input__field"
                      type="text"
                      value={firstName}
                      maxLength={maxLength}
                      placeholder={inputLabels.firstNameHint}
                      autoComplete="off"
                      spellCheck={false}
                      aria-invalid={nameError ? true : undefined}
                      onChange={(event) => {
                        setFirstName(event.target.value);
                        setNameError('');
                      }}
                      autoFocus
                    />
                  </label>
                  <label className="certificate-input">
                    <span className="certificate-input__label">{inputLabels.lastName}</span>
                    <input
                      className="certificate-input__field"
                      type="text"
                      value={lastName}
                      maxLength={maxLength}
                      placeholder={inputLabels.lastNameHint}
                      autoComplete="off"
                      spellCheck={false}
                      aria-invalid={nameError ? true : undefined}
                      onChange={(event) => {
                        setLastName(event.target.value);
                        setNameError('');
                      }}
                    />
                  </label>
                </div>
              ) : (
                <p className={`certificate-name${legalName ? '' : ' certificate-name--empty'}`}>
                  {legalName}
                </p>
              )}

              {allowInput ? (
                <p id="certificate-hint" className="certificate-hint">
                  {labels.fileHint}
                </p>
              ) : null}
              {nameError ? (
                <p id="certificate-error" className="certificate-error" role="alert">
                  {nameError}
                </p>
              ) : null}
              <p className="certificate-text">{labels.body}</p>
            </section>

            <footer className="certificate-footer">
              <div className="certificate-meta">
                <div className="certificate-field">
                  <span className="certificate-field__label">{labels.issuedOn}</span>
                  <span className="certificate-field__value">{issuedDate}</span>
                </div>
                <div className="certificate-field">
                  <span className="certificate-field__label">{labels.certificateNo}</span>
                  <span className="certificate-field__value certificate-field__value--mono">
                    {certificateNo}
                  </span>
                </div>
                <div className="certificate-signature">
                  <span className="certificate-signature__line" />
                  <span className="certificate-signature__caption">{labels.registrar}</span>
                </div>
              </div>

              <div className="certificate-actions">
                <button type="button" className="certificate-cancel" onClick={dismiss} disabled={submitting}>
                  {labels.close}
                </button>
                {allowConfirm ? (
                  <button
                    type="submit"
                    className={`certificate-file${stamping ? ' certificate-file--stamping' : ''}`}
                    disabled={!canConfirm || submitting}
                    aria-label={labels.confirm}
                  >
                    {labels.confirm}
                  </button>
                ) : null}
              </div>
            </footer>
          </form>
        </div>
      </div>
    </div>
  );
}
