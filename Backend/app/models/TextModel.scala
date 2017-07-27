package models
import slick.driver.PostgresDriver.api._
import play.api.libs.json.Json

/**
  * Created by thanh-tamle on 11/16/16.
  */

case class TextModel(id: Long, text: String, width: Int, height: Int, posX: Int, posY: Int, isSent: Int, deleteFlag: Boolean) {
  implicit val accountTypeWrites = Json.format[TextModel]
}

class TextModels(tag: Tag) extends Table[TextModel](tag, "text") {

  def id = column[Long]("id", O.PrimaryKey, O.AutoInc)

  def text = column[String]("text")

  def width = column[Int]("width")

  def height = column[Int]("height")

  def posX = column[Int]("pos_x")

  def posY = column[Int]("pos_y")

  def isSent = column[Int]("is_sent")

  def delFlag = column[Boolean]("del_flag")

  override def * = (id, text, width, height, posX, posY, isSent, delFlag) <> (TextModel.tupled, TextModel.unapply)
}