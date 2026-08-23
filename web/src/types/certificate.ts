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
  maxLength: number;
  issuedDate: string;
  certificateNo: string;
  labels: CertificateLabels;
  inputLabels?: CertificateInputLabels | null;
};

export const defaultLabels: CertificateLabels = {
  issuer: 'Department of Records',
  title: 'Certificate of Name Change',
  subtitle: 'State of San Andreas',
  lead: 'This petitions that',
  body: 'be recorded as their legal name.',
  issuedOn: 'Issued',
  certificateNo: 'Certificate no.',
  registrar: 'City Clerk',
  confirm: 'File',
  close: 'Cancel',
  fileHint: 'Letters only, 32 characters max',
  invalidName: 'Letters only. That name isn\'t allowed.',
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
  maxLength: 32,
  issuedDate: 'July 6, 2026',
  certificateNo: 'NC-20260706-A3F2',
  labels: defaultLabels,
  inputLabels: defaultInputLabels,
};
