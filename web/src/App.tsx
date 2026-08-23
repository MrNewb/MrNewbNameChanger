import { useCallback, useState } from 'react';
import { Certificate } from './components/Certificate';
import { useNuiAction } from './hooks/nui';
import {
  browserPayload,
  defaultInputLabels,
  defaultLabels,
  type CertificateOpenPayload,
} from './types/certificate';
import { isEnvBrowser } from './utils/env';

function normalizePayload(data: CertificateOpenPayload): CertificateOpenPayload {
  const labels = data.labels ?? defaultLabels;
  const inputLabels = data.inputLabels ?? defaultInputLabels;

  return {
    action: 'openCertificate',
    documentType: data.documentType === 'marriage' ? 'marriage' : 'namechange',
    firstName: data.firstName ?? '',
    lastName: data.lastName ?? '',
    allowConfirm: data.allowConfirm !== false,
    allowInput: data.allowInput === true,
    maxLength: Number(data.maxLength) > 0 ? Number(data.maxLength) : 32,
    issuedDate: data.issuedDate ?? '',
    certificateNo: data.certificateNo ?? '',
    labels: {
      issuer: labels.issuer ?? defaultLabels.issuer,
      title: labels.title ?? defaultLabels.title,
      subtitle: labels.subtitle ?? defaultLabels.subtitle,
      lead: labels.lead ?? defaultLabels.lead,
      body: labels.body ?? defaultLabels.body,
      issuedOn: labels.issuedOn ?? defaultLabels.issuedOn,
      certificateNo: labels.certificateNo ?? defaultLabels.certificateNo,
      registrar: labels.registrar ?? defaultLabels.registrar,
      confirm: labels.confirm ?? defaultLabels.confirm,
      close: labels.close ?? defaultLabels.close,
      fileHint: labels.fileHint ?? defaultLabels.fileHint,
      invalidName: labels.invalidName ?? defaultLabels.invalidName,
    },
    inputLabels: data.allowInput === true
      ? {
          firstName: inputLabels.firstName ?? defaultInputLabels.firstName,
          lastName: inputLabels.lastName ?? defaultInputLabels.lastName,
          firstNameHint: inputLabels.firstNameHint ?? defaultInputLabels.firstNameHint,
          lastNameHint: inputLabels.lastNameHint ?? defaultInputLabels.lastNameHint,
        }
      : null,
  };
}

export default function App() {
  const [visible, setVisible] = useState(isEnvBrowser());
  const [payload, setPayload] = useState<CertificateOpenPayload>(
    isEnvBrowser() ? browserPayload : normalizePayload(browserPayload),
  );

  const handleClose = useCallback(() => {
    setVisible(false);
  }, []);

  useNuiAction<CertificateOpenPayload>('openCertificate', (data) => {
    setPayload(normalizePayload(data));
    setVisible(true);
  });

  if (!visible) return null;

  return <Certificate payload={payload} onClose={handleClose} />;
}
