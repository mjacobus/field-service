'use strict';

/** global: google */

// https://developers.google.com/maps/documentation/javascript/examples/polygon-hole
// https://developers.google.com/maps/documentation/javascript/examples/polygon-arrays
// https://developers.google.com/maps/documentation/javascript/examples/control-custom
// https://gist.github.com/christophercliff/1380958

class TerritoryMap {
  static draw({ container, territory }) {
    const map = new google.maps.Map(container, {
      zoom: 15,
      mapTypeId: 'terrain'
    });

    const territoryMap = new TerritoryMap({ territory, map });
    territoryMap.draw(map);
    return territoryMap;
  }

  constructor({ territory, container, map }) {
    this.getMarkers = this._getMarkers.bind(this);
    this.centralize = this.centralize.bind(this);
    this.drawEditor = this.drawEditor.bind(this);
    this.loadPolygon = this.loadPolygon.bind(this);

    this.map = map;
    this.territory = territory;
    this.markers = this._getMarkers();
  }

  draw() {
    this.centralize();

    const map = this.map;

    this.markers.forEach((marker) => {
      new google.maps.Marker({
        position: new google.maps.LatLng(marker.position.lat, marker.position.lon),
        icon: Icons.mapPin,
        map: map,
        title: marker.title
      });
    });

    this.drawEditor();
    this.loadPolygon();
  }

  _getMarkers() {
    const householders = this.territory.householders.filter(
      (householder) => householder.geolocation.present
    );

    return householders.map((householder) => {
      return {
        title: [householder.address, householder.name].join("\n"),
        position: {
          lat: householder.geolocation.lat,
          lon: householder.geolocation.lon
        }
      };
    });
  }

  drawEditor() {
    const drawingManager = new google.maps.drawing.DrawingManager({
      drawingControl: true,
      drawingControlOptions: {
        position: google.maps.ControlPosition.TOP_CENTER,
        drawingModes: ['polygon']
      },
      polygonOptions: {
        fillColor: null,
        fillOpacity: 0,
        strokeWeight: 2,
        clickable: false,
        editable: !true,
        zIndex: 1
      }
    });

    drawingManager.setMap(this.map);


    google.maps.event.addListener(drawingManager, 'polygoncomplete', this.logCoordenates);
  }

  logCoordenates(poly) {
    const coordinates = [];
    poly.getPath().forEach((loc) => coordinates.push({ lat: loc.lat(), lng: loc.lng() }));
    console.log(coordinates);
  }

  loadPolygon() {
    // Define the LatLng coordinates for the polygon.
    const coordenates = [
      {"lat":53.60867598539801,"lng":10.072360038757324},
      {"lat":53.608523215851946,"lng":10.05497932434082},
      {"lat":53.60765751131828,"lng":10.043349266052246},
      {"lat":53.608268598713714,"lng":10.03849983215332},
      {"lat":53.60737742664013,"lng":10.032663345336914},
      {"lat":53.61478631406239,"lng":10.031118392944336},
      {"lat":53.620921212685346,"lng":10.031933784484863},
      {"lat":53.62305930807108,"lng":10.032620429992676},
      {"lat":53.625299101357854,"lng":10.03352165222168},
      {"lat":53.625731774998144,"lng":10.034337043762207},
      {"lat":53.626138993195696,"lng":10.03824234008789},
      {"lat":53.6258844822827,"lng":10.039830207824707},
      {"lat":53.62519729515075,"lng":10.041890144348145},
      {"lat":53.62509548869807,"lng":10.0435209274292},
      {"lat":53.62522274672555,"lng":10.045194625854492},
      {"lat":53.625019133697414,"lng":10.046825408935547},
      {"lat":53.624535548818514,"lng":10.048027038574219},
      {"lat":53.62425557609283,"lng":10.048456192016602},
      {"lat":53.62402650611769,"lng":10.048799514770508},
      {"lat":53.623313836021744,"lng":10.049099922180176},
      {"lat":53.623288383295765,"lng":10.05098819732666},
      {"lat":53.623288383295765,"lng":10.051460266113281},
      {"lat":53.62321202502567,"lng":10.052146911621094},
      {"lat":53.62336474142767,"lng":10.052876472473145},
      {"lat":53.62293204352015,"lng":10.052833557128906},
      {"lat":53.62333928873238,"lng":10.053949356079102},
      {"lat":53.623797434899224,"lng":10.054378509521484},
      {"lat":53.62383561352197,"lng":10.054796934127808},
      {"lat":53.624001053821466,"lng":10.054947137832642},
      {"lat":53.624001053821466,"lng":10.059399604797363},
      {"lat":53.62428102823557,"lng":10.060333013534546},
      {"lat":53.62445919280479,"lng":10.061405897140503},
      {"lat":53.624535548818514,"lng":10.062350034713745},
      {"lat":53.624535548818514,"lng":10.065847635269165},
      {"lat":53.62456736378346,"lng":10.070385932922363},
      {"lat":53.6221939015574,"lng":10.070278644561768},
      {"lat":53.622200264905366,"lng":10.073164701461792},
      {"lat":53.62220662825234,"lng":10.076855421066284},
      {"lat":53.622282988341325,"lng":10.076984167098999},
      {"lat":53.62222571828755,"lng":10.083335638046265},
      {"lat":53.620202126506804,"lng":10.081597566604614},
      {"lat":53.61938120784132,"lng":10.080792903900146},
      {"lat":53.61863027601123,"lng":10.079805850982666},
      {"lat":53.616606511858436,"lng":10.07723093032837},
      {"lat":53.615830073445565,"lng":10.076544284820557},
      {"lat":53.61435352821358,"lng":10.076136589050293},
      {"lat":53.61337337915543,"lng":10.075621604919434},
      {"lat":53.61183309894835,"lng":10.074419975280762},
      {"lat":53.61115841306225,"lng":10.073904991149902},
      {"lat":53.60983446980236,"lng":10.073411464691162},
      {"lat":53.60933798037789,"lng":10.073132514953613}
    ];

    // Construct the polygon.
    const savedTerritory = new google.maps.Polygon({
      paths: coordenates,
      editable: true,
      strokeColor: '#FF0000',
      strokeOpacity: 0.8,
      strokeWeight: 3,
      fillColor: '#FF0000',
      fillOpacity: 0
    });
    savedTerritory.setMap(this.map);

    google.maps.event.addListener(savedTerritory.getPath(), 'set_at', () => {
      console.log('set_at');
      this.logCoordenates(savedTerritory);
    });

    google.maps.event.addListener(savedTerritory.getPath(), 'insert_at', () => {
      console.log('insert_at');
      this.logCoordenates(savedTerritory);
    });

    google.maps.event.addListener(savedTerritory.getPath(), 'remove_at', () => {
      console.log('remove_at');
      this.logCoordenates(savedTerritory);
    });
  }

  centralize() {
    // sum of lat/lon
    const sum = this.markers.reduce((accumulator, marker) => {
      accumulator.lat += marker.position.lat;
      accumulator.lng += marker.position.lon;

      return accumulator;
    }, { lat: 0, lng: 0 });

    // average of lat/lon
    const length = this.markers.length;
    const average = { lat: sum.lat/length, lng: sum.lng/length };

    this.map.setCenter(average);

    const center = {
      "lat": 53.61675820991791,
      "lng": 10.0572270154953
    }

    this.map.setCenter(center);
  }

}
