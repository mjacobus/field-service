# Field Service

My personal field service helper

[![Rails Unit Tests](https://github.com/mjacobus/field-service/actions/workflows/rails-unit-tests.yml/badge.svg)](https://github.com/mjacobus/field-service/actions/workflows/rails-unit-tests.yml)
[![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/mjacobus/field-service/badges/quality-score.png?b=master)](https://scrutinizer-ci.com/g/mjacobus/field-service/?branch=master)
[![Issue Count](https://codeclimate.com/github/mjacobus/field-service/badges/issue_count.svg)](https://codeclimate.com/github/mjacobus/field-service)
[![BCH compliance](https://bettercodehub.com/edge/badge/mjacobus/field-service?branch=master)](https://bettercodehub.com/)
[![Coverage Status](https://coveralls.io/repos/github/mjacobus/field-service/badge.svg)](https://coveralls.io/github/mjacobus/field-service)

## Notes to self

### Installing

Copy .env.example to .env and change accordingly.

```
./bin/setup
```

### Running

```
yarn run start
```

- [Api](http://localhost:3000)
- [Client](http://localhost:3001)

### Importing/exporting

```bash
rake csv:householders:import     # will import CSVs inside csv/to_import prefixed with householders_
rake csv:householders:export_all # will export to csv/exports
```

#### CSV columns:

- `territory_name` - required
- `street_name` - required
- `house_number` - required
- `name` - required
- `show` - (yes|no) required
- `uuid`
- `updated_at`

### React Frontend

#### The current structure of this project

- actions
- containers/pages/
- helpers - utils that may be business dependent
- seletors - God knows ;-)
- translations
- utils - utils that are business agnostic
- views/components/ - components that are business agnostic
- views/pages/shared/ - components that are business dependent
- views/pages/{resource}/{action} - rails like naming for views - I.E. territories/show.js


### Resources

- [react-bootstrap](https://react-bootstrap.github.io/getting-started.html)
- https://htmlpdfapi.com/blog/export_google_map_to_pdf
- Maps
  - https://developers.google.com/maps/documentation/static-maps/usage-limits
  - https://developers.google.com/maps/documentation/javascript/examples/polygon-hole
  - https://developers.google.com/maps/documentation/javascript/examples/polygon-arrays
  - https://developers.google.com/maps/documentation/javascript/examples/control-custom
  - https://gist.github.com/christophercliff/1380958
  - Examples:
    - [lines](http://maps.google.com/maps/api/staticmap?size=400x400&zoom=13&path=color:0xff0000ff|weight:2|40.737102,-73.990318|40.749825,-73.987963&markers=color%3ablue|label%3aS|40.737102,-73.990318|40.749825,-73.987963&sensor=false)
    - [lines](http://maps.googleapis.com/maps/api/staticmap?center=33.402285,-111.94271500000002&zoom=20&size=600x600&maptype=satellite&sensor=false&path=color%3ared%7Cweight:1%7Cfill%3awhite%7C33.4022475,-111.9426775%7C33.4022475,-111.9427525%7C33.4023225,-111.9427525%7C33.4023225,-111.9426775%7C33.4022475,-111.9426775)
- [Open Street Maps - Overlays](https://wiki.openstreetmap.org/wiki/Overlay_API#Polyline)
- [Open Street Maps - Overlays 2](https://wiki.openstreetmap.org/wiki/Khtml_Maplib_API)
- Alternative Static maps
  - [Static map maker](https://staticmapmaker.com/)
  - [Map Box](https://www.mapbox.com/help/how-static-maps-work/)
  - [here](https://developer.here.com/api-explorer/rest/map-image/map-image-width-height)
