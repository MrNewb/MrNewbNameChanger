export type CertificateLabels = {
  issuer: string;
  title: string;
  subtitle: string;
  lead: string;
  body: string;
  issuedOn: string;
  certificateNo: string;
  registrar: string;
  confirm: string;
  close: string;
  fileHint: string;
  invalidName: string;
};

export type CertificateInputLabels = {
  firstName: string;
  lastName: string;
  firstNameHint: string;
  lastNameHint: string;
};

export type CertificateOpenPayload = {
  action: 'openCertificate';
  documentType: 'marriage' | 'namechange';
  firstName: string;
  lastName: string;
  allowConfirm: boolean;
  allowInput: boolean;
  issuedDate: string;
  certificateNo: string;
  labels: CertificateLabels;
  inputLabels?: CertificateInputLabels | null;
};

export const defaultLabels: CertificateLabels = {
  issuer: 'Department of Records',
  title: 'Certificate of Legal Name Change',
  subtitle: 'State of San Andreas',
  lead: 'This document petitions that',
  body: 'Upon filing, the name above becomes the legal name of record.',
  issuedOn: 'Issued on',
  certificateNo: 'Certificate no.',
  registrar: 'Registrar of vital records',
  confirm: 'File',
  close: 'Cancel',
  fileHint: 'Letters only · 32 characters · files immediately',
  invalidName: 'That name is not allowed. Use letters only and avoid restricted words.',
};

export const defaultInputLabels: CertificateInputLabels = {
  firstName: 'First name',
  lastName: 'Last name',
  firstNameHint: 'First name',
  lastNameHint: 'Last name',
};

export const browserPayload: CertificateOpenPayload = {
  action: 'openCertificate',
  documentType: 'namechange',
  firstName: '',
  lastName: '',
  allowConfirm: true,
  allowInput: true,
  issuedDate: 'July 6, 2026',
  certificateNo: 'NC-20260706-A3F2',
  labels: defaultLabels,
  inputLabels: defaultInputLabels,
};
