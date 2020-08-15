abstract class BaseEntityMapper<ENTITY, MODAL> {
  MODAL mapToModal(ENTITY entity);

  ENTITY mapToEntity(MODAL modal);

  List<ENTITY> mapToEntities(List<MODAL> models) {
    var entities = List<ENTITY>();
    if (models != null) {
      models.forEach((it) {
        ENTITY entity = mapToEntity(it);
        entities.add(entity);
      });
    }
    return entities;
  }

  List<MODAL> mapToModals(List<ENTITY> entities) {
    var modals = List<MODAL>();
    if (modals != null) {
      entities.forEach((it) {
        modals.add(mapToModal(it));
      });
    }
    return modals;
  }
}
