import t from './helpers/translate';

const translate = t.html;
const text = t.text;

const translations = {
  no: translate('no'),
  yes: translate('yes'),
  delete: translate('delete'),
  save: translate('save'),
  edit: translate('edit'),
  confirmDelete: (item) => {
    return text('confirmDelete', { values: { item }});
  },
  dateFormatPlaceholder: translate('dateFormatPlaceholder'),
  addHouseholder: translate('addHouseholder'),
  newTerritory: translate('newTerritory'),
  mapsOverview: translate('mapsOverview'),
  address: translate('address'),
  streetName: translate('streetName'),
  houseNumber: translate('houseNumber'),
  speakTheLanguage: translate('speakTheLanguage'),
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
  doNotVisitDate: translate('doNotVisitDate'),
  downloadPdf: translate('downloadPdf'),
  dueDate: translate('dueDate'),
  hideAssignments: translate('hideAssignments'),
  hideHouseholders: translate('hideHouseholders'),
  loading: translate('loading'),
  logout: translate('logout'),
  name: translate('name'),
  numberOfHouseholders: translate('numberOfHouseholders'),
  publishers: translate('publishers'),
  pendingReturn: translate('pendingReturn'),
  profile: translate('profile'),
  returnedAt: translate('returnedAt'),
  returnTerritory: translate('returnTerritory'),
  responsible: translate('responsible'),
  search: translate('search'),
  showAssignments: translate('showAssignments'),
  showHouseholders: translate('showHouseholders'),
  showMap: translate('showMap'),
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
