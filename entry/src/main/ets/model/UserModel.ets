import relationalStore from '@ohos.data.relationalStore';
import Farmland from '../viewmodel/Farmland';
import User from '../viewmodel/User';

class UserModel {
  private rdbStore: relationalStore.RdbStore
  private tableName: string = 'USER'

  /**
   * 初始化任务表
   */
  initTaskDB(context) {
    //1.rdb配置
    const config = {
      name: 'user.db',
      securityLevel: relationalStore.SecurityLevel.S1
    }
    //2.初始化sql语句
    const sql = `CREATE TABLE IF NOT EXISTS USER (
                  ID INTEGER PRIMARY KEY AUTOINCREMENT,
                  USERNAME TEXT NOT NULL,
                  PASSWORD TEXT NOT NULL
                  )`

    //3.获取rdb
    relationalStore.getRdbStore(context, config, (err, rdbStore) => {
      if (err) {
        console.log('testTag', '获取user失败')
        return
      }
      //执行sql语句
      try {
        rdbStore.executeSql(sql)
        console.log('testTag', '创建USER表成功!')
        this.rdbStore = rdbStore
      } catch (e) {
        console.log('testTag', e)
      }
      // 保存rdbStore
    })
  }

  async getUser(username: string) {
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('USERNAME', username)
    let result = await this.rdbStore.query(predicates, ['ID', 'USERNAME', 'PASSWORD'])
    if (!result.isAtLastRow) {
      result.goToNextRow()
      try {
        let id = result.getLong(result.getColumnIndex('ID'))
        let username = result.getString(result.getColumnIndex('USERNAME'))
        let password = result.getString(result.getColumnIndex('PASSWORD'))

        let user: User = new User(id, username, password)
        console.log('testTag', '查询农田详情成功')
        console.log('testTag', '查询到数据：', JSON.stringify(user))
        return user
      } catch (e) {
        console.log('testTag', `用户信息${e}`)
      }
    }
  }
  /**
   * 添加一个新的任务
   * @param name 任务名称
   * @returns 任务id
   */
  addUser(username: string, password: string): Promise<number> {
    return this.rdbStore.insert(this.tableName, { username, password })
  }

  /**
   * 根据id修改密码
   * @param id
   * @param finished 任务是否完成
   */
  updateUser(id: number, password: string) {
    // 1.要更新的数据
    let data = { password }
    // 2.更新的条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    // 3.更新操作
    return this.rdbStore.update(data, predicates)
  }

  /**
   * 根据id注销用户
   * @param id 任务id
   */
  deleteUserById(id: number) {
    // 1.删除的条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    // 2.删除操作
    return this.rdbStore.delete(predicates)
  }
}

export default new UserModel();

