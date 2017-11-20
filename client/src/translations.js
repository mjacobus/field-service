import t from './helpers/translate';

const translate = t.html;
const text = t.text;

const translations = {
  no: translate('no'),
  yes: translate('yes'),
  delete: translate('delete'),
  confirmDelete: (item) => {
    return text('confirmDelete', { values: { item }});
  },
  dateFormatPlaceholder: translate('dateFormatPlaceholder'),
  addHouseholder: translate('addHouseholder'),
  address: translate('address'),
  assignedAt: translate('assignedAt'),
  assignTerritory: translate('assignTerritory'),
  assignedTo: translate('assignedTo'),
  back: translate('back'),
  cancel: translate('cancel'),
  city: translate('city'),
  confirmReturn: translate('confirmReturn'),
  currentAssignee: translate('currentAssignee'),
  description: translate('description'),
  doNotVisit: translate('doNotVisit'),
  downloadPdf: translate('downloadPdf'),
  dueDate: translate('dueDate'),
  hideAssignments: translate('hideAssignments'),
  hideHouseholders: translate('hideHouseholders'),
  loading: translate('loading'),
  name: translate('name'),
  numberOfHouseholders: translate('numberOfHouseholders'),
  publishers: translate('publishers'),
  pendingReturn: translate('pendingReturn'),
  returnedAt: translate('returnedAt'),
  returnTerritory: translate('returnTerritory'),
  search: translate('search'),
  showAssignments: translate('showAssignments'),
  showHouseholders: translate('showHouseholders'),
  territoryAssignments: translate('territoryAssignments'),
  territories: translate('territories'),
  territoriesFound: (numberOfTerritories) => {
    return translate('territoriesFound', { values: { number: numberOfTerritories } })
  },
  territoryCompletelyWorked: translate('territoryCompletelyWorked'),
  territoryNotCompletelyWorked: translate('territoryNotCompletelyWorked'),
  territoryWorkInProgress: translate('territoryWorkInProgress'),
  testSystemMessage: translate('testSystemMessage'),
};

export default translations
