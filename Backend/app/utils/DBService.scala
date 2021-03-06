package utils

import slick.dbio.{DBIOAction, NoStream}
import slick.driver.PostgresDriver.api._

import scala.concurrent.duration.Duration
import scala.concurrent.{Await, Future}

object DBService {
  val db = Database.forConfig("weddingDB")

  def runAsync[R](a: DBIOAction[R, NoStream, Nothing]): Future[R] = {
    db.run(a)
  }

  def run[R](a: DBIOAction[R, NoStream, Nothing]): R = {
    Await.result(runAsync(a), Duration.Inf)
  }

  def close() = {
    db.close();
  }

}
