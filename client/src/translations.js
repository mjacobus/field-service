import translate from './helpers/translate';

const translations = {
  addHouseholder: translate('addHouseholder'),
  address: translate('address'),
  assignedAt: translate('assignedAt'),
  assignedTo: translate('assignedTo'),
  back: translate('back'),
  city: translate('city'),
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
