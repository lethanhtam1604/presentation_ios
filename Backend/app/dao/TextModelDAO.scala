package dao

/**
  * Created by thanh-tamle on 11/16/16.
  */

import models._
import slick.driver.PostgresDriver.api._
import slick.lifted.TableQuery
import utils.DBManager


object TextModelDAO {

  private val DBManager = new DBManager()
  private val textModels = TableQuery[TextModels]

  def all(): Seq[TextModel] = {
    DBManager.run(textModels.result)
  }

  def delete(id: Long) {
    val q = for {c <- textModels if c.id === id} yield c.delFlag
    val updateAction = q.update(true)
    DBManager.run(updateAction)
  }

  def add(textModel: TextModel) = {
    val insertQuery = textModels returning textModels.map(_.id) into ((item, id) => item.copy(id = id))
    val action = insertQuery += textModel
    DBManager.run(action)
  }

  def get(id: Long): TextModel = {
    val item = DBManager.run(textModels.filter(_.id === id).result.headOption)
    item match {
      case Some(f) =>
        item.get
      case None =>
        null
    }
  }

  def getNew(): Seq[TextModel] = {
    val item = DBManager.run(textModels.filter(_.isSent === 0).result)
    item
  }

  def setSent(id: Long) = {
    val q = for { c <- textModels if c.id === id } yield c.isSent
    val updateAction = q.update(1)
    updateAction
  }
}
