package controllers

import javax.inject.Inject

import models.ImageModel.ImageRow
import play.api.libs.json._
import play.api.mvc.{Action, BodyParsers, Controller}


class BaseApi @Inject() extends Controller {

  val baseService = new BaseService()

  def upload = Action(BodyParsers.parse.json) { implicit request =>
    val e = request.body.validate[ImageRow]
    e.fold(
      errors => {
        BadRequest(Json.obj("status" -> "Error", "message" -> JsError.toFlatJson(errors)))
      },
      imageRow => {
        baseService.upload(imageRow)
        Ok(Json.toJson(imageRow))
      }
    )
  }

  def getNew = Action { implicit request =>
    val rs: Seq[_root_.models.ImageModel.ImageRow] = baseService.getNew
    Ok(Json.toJson(rs))
  }

}
