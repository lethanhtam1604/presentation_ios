package models

import play.api.libs.json.Json
import slick.dbio.Effect.{Read, Write}
import slick.driver.PostgresDriver.api._
import slick.profile.{FixedSqlAction, FixedSqlStreamingAction, SqlAction}

object ImageModel extends {
  val profile = slick.driver.PostgresDriver
} with ImageModel


trait ImageModel {

  case class ImageRow(id: Long, code: String, width: Int, height: Int, posX: Int, posY: Int, isSent: Int)

  implicit val ImageRowWrites = Json.format[ImageRow]


  class Image(tag: Tag) extends Table[ImageRow](tag, "image") {
    def id = column[Long]("id", O.PrimaryKey, O.AutoInc)

    def code = column[String]("code")

    def width = column[Int]("width")

    def height = column[Int]("height")

    def posX = column[Int]("pos_x")

    def posY = column[Int]("pos_y")

    def isSent = column[Int]("is_sent")

    override def * = (id, code, width, height, posX, posY, isSent) <> (ImageRow.tupled, ImageRow.unapply)
  }

  lazy val Image = TableQuery[Image]


  def addOrUpdate(row: ImageRow): FixedSqlAction[Option[Long], NoStream, Write] = {
    val rs = (Image returning Image.map(_.id)).insertOrUpdate(row)
    rs
  }


  def get(id: Long): SqlAction[Option[ImageRow], NoStream, Read] = {
    val rs = Image.filter(_.id === id).result.headOption
    rs
  }

  def getNew = {
    val rs = Image.filter(_.isSent === 0).result
    rs
  }

  def setSent(id:Long) = {
    val q = for { c <- Image if c.id === id } yield c.isSent
    val updateAction = q.update(1)
    updateAction
  }

  def listAll: FixedSqlStreamingAction[Seq[ImageRow], ImageRow, Read] = {
    val rs = Image.result
    rs
  }
}