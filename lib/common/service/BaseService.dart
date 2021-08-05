abstract class BaseService<TDto, TId> {

  /**
   * Find All.
   *
   * @return the t list entity
   */
  Future<List<TDto>> getALl();

  /**
   * Find All.
   *
   * @return the t list entity
   */
  Future<List<TDto>> findById(TId id);

  /**
   * Update.
   *
   * @param dto the dto
   * @param decryptedKey the decrypted key
   * @return the t dto
   */
  Future<TDto> update(TId id, TDto dto);
}