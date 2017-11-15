// Link.react-test.js
import React from 'react';
import renderer from 'react-test-renderer';
import {IntlProvider} from 'react-intl';

import TerritoryIndex from '../../../../views/pages/territories/territory-list.js'

test.skip('can be created', () => {
  const props = {
    onInitialize: jest.fn()
  };

  renderer.create(
    <IntlProvider locale='en'>
      <TerritoryIndex {...props} />
    </IntlProvider>
  );
});
