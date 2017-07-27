package controllers

import javax.inject._

import dao.TextModelDAO
import models._
import play.api.libs.json.{JsError, Json}
import play.api.mvc._
import utils.DBService

/**
  * Created by thanh-tamle on 11/17/16.
  */

@Singleton
class HomeController @Inject() extends Controller {
  implicit val textWrites = Json.writes[TextModel]
  implicit val textReads = Json.reads[TextModel]

  def getNewText = Action {
    val newTextList = TextModelDAO.getNew()
    newTextList.map{i => DBService.run(TextModelDAO.setSent(i.id))}
    Ok(Json.toJson(newTextList))
  }

  def addNewText = Action(BodyParsers.parse.json) { implicit request =>
    val e = request.body.validate[TextModel]
    e.fold(
      errors => {
        BadRequest(Json.obj("status" -> "Error", "message" -> JsError.toFlatJson(errors)))
      },
      textModel => {
        TextModelDAO.add(textModel)
        Ok(Json.toJson(textModel))
      }
    )
  }
}
