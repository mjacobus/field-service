'use strict';

class TerritoryAssignmentService {
  update(id, payload) {
    const url = AppRoutes.updateTerritoryAssignment(id);

    return $.ajax({
      url: url,
      type: 'PATCH',
      data: { territory_assignment: payload }
    });
  };
}
