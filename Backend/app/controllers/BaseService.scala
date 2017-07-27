package controllers

import models.ImageModel.ImageRow
import utils.DBService

class BaseService extends BaseServiceTrait{

}
trait BaseServiceTrait {

  def upload(imageRow: ImageRow) = {
    DBService.run(models.ImageModel.addOrUpdate(imageRow))
  }

  def getNew = {
    val rs: Seq[_root_.models.ImageModel.ImageRow] = DBService.run(models.ImageModel.getNew)
    rs.map{i => DBService.run(models.ImageModel.setSent(i.id))}
    rs
  }
}
