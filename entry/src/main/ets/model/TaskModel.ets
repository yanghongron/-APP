import relationalStore from '@ohos.data.relationalStore';
import Farmland from '../viewmodel/Farmland';

class TaskModel {
  private rdbStore: relationalStore.RdbStore
  private tableName: string = 'LAND'

  /**
   * 初始化任务表
   */
  initTaskDB(context) {
    //1.rdb配置
    const config = {
      name: 'farmland.db',
      securityLevel: relationalStore.SecurityLevel.S1
    }
    //2.初始化sql语句
    const sql = `CREATE TABLE IF NOT EXISTS LAND (
                  ID INTEGER PRIMARY KEY AUTOINCREMENT,
                  NAME TEXT NOT NULL,
                  temperature INTEGER NOT NULL,
                  airHumidity INTEGER NOT NULL,
                  soilMoisture INTEGER NOT NULL,
                  co2 INTEGER NOT NULL,
                  light INTEGER NOT NULL,
                  mDay bit,
                  mWeek bit,
                  mMonth bit,
                  qiDong TEXT,
                  kaiGua bit
                  )`

    //3.获取rdb
    relationalStore.getRdbStore(context, config, (err, rdbStore) => {
      if (err) {
        console.log('testTag', '获取rdbStore失败')
        return
      }
      //执行sql语句
      try {
        rdbStore.executeSql(sql)
        console.log('testTag', '创建LAND表成功!')
        this.rdbStore = rdbStore
      } catch (e) {
        console.log('testTag', e)
      }
      // 保存rdbStore
    })
  }

  /**
   * 查询农田列表
   */
  async getTaskList() {
    // 1.构建查询条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    console.log('testTag', '调试：1');
    // 2.查询
    let result = await this.rdbStore.query(predicates, ['ID', 'NAME', 'temperature', 'airHumidity', 'soilMoisture', 'co2', 'light','mDay','mWeek','mMonth', 'qiDong', 'kaiGua'])
    console.log('testTag', result);
    console.log('testTag', '调试：1');

    // 3.解析查询结果
    // 3.1.定义一个数组，组装最终的查询结果
    let tasks: Farmland[] = []
    console.log('testTag', '调试：2');

    // 3.2.遍历封装
    try {
      console.log('testTag', '调试：3');

      while (!result.isAtLastRow) {
        console.log('testTag', '调试：4');

        // 3.3.指针移动到下一行
        result.goToNextRow()
        console.log('testTag', '调试：5');
        // 3.4.获取数据
        let id = result.getLong(result.getColumnIndex('ID'))
        console.log('testTag', '调试：6');
        let name = result.getString(result.getColumnIndex('NAME'))
        let temperature = result.getLong(result.getColumnIndex('temperature'))
        let airHumidity = result.getLong(result.getColumnIndex('airHumidity'))
        let soilMoisture = result.getLong(result.getColumnIndex('soilMoisture'))
        let cO2 = result.getLong(result.getColumnIndex('co2'))
        let light = result.getLong(result.getColumnIndex('light'))
        let mDay = result.getLong(result.getColumnIndex('mDay'))
        let mWeek = result.getLong(result.getColumnIndex('mWeek'))
        let mMonth = result.getLong(result.getColumnIndex('mMonth'))
        let qiDong = result.getString(result.getColumnIndex('qiDong'))
        let kaiGua = result.getLong(result.getColumnIndex('kaiGua'))
        tasks.push({
          id,
          name,
          temperature,
          airHumidity,
          soilMoisture,
          cO2,
          light,
          mDay: !!mDay,
          mWeek: !!mWeek,
          mMonth: !!mMonth,
          qiDong,
          kaiGua: !!kaiGua
        })
        // 3.5.封装到数组
      }
    } catch (e) {
      console.log('testTag', e)
    }
    console.log('testTag', '查询到数据：', JSON.stringify(tasks))
    return tasks
  }

  /**
   * 查询任务列表
   */
  async getTaskListF() {
    console.log('testTag', '调试：1');

    // 1.构建查询条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('kaiGua', true)
    // 2.查询
    let result = await this.rdbStore.query(predicates, ['ID', 'NAME', 'temperature', 'airHumidity', 'soilMoisture', 'co2', 'light','mDay','mWeek','mMonth', 'qiDong', 'kaiGua'])
    console.log('testTag', result);
    // 3.解析查询结果
    // 3.1.定义一个数组，组装最终的查询结果
    let tasksF: Farmland[] = []
    console.log('testTag', '调试：2');

    // 3.2.遍历封装
    try {
      console.log('testTag', '调试：3');

      while (!result.isAtLastRow) {
        console.log('testTag', '调试：4');

        // 3.3.指针移动到下一行
        result.goToNextRow()
        console.log('testTag', '调试：5');
        // 3.4.获取数据
        let id = result.getLong(result.getColumnIndex('ID'))
        console.log('testTag', '调试：6');
        let name = result.getString(result.getColumnIndex('NAME'))
        let temperature = result.getLong(result.getColumnIndex('temperature'))
        let airHumidity = result.getLong(result.getColumnIndex('airHumidity'))
        let soilMoisture = result.getLong(result.getColumnIndex('soilMoisture'))
        let cO2 = result.getLong(result.getColumnIndex('co2'))
        let light = result.getLong(result.getColumnIndex('light'))
        let mDay = result.getLong(result.getColumnIndex('mDay'))
        let mWeek = result.getLong(result.getColumnIndex('mWeek'))
        let mMonth = result.getLong(result.getColumnIndex('mMonth'))
        let qiDong = result.getString(result.getColumnIndex('qiDong'))
        let kaiGua = result.getLong(result.getColumnIndex('kaiGua'))
        tasksF.push({
          id,
          name,
          temperature,
          airHumidity,
          soilMoisture,
          cO2,
          light,
          mDay: !!mDay,
          mWeek: !!mWeek,
          mMonth: !!mMonth,
          qiDong,
          kaiGua: !!kaiGua
        })
        // 3.5.封装到数组
      }
    } catch (e) {
      console.log('testTag', e)
    }
    console.log('testTag', '查询到数据：', JSON.stringify(tasksF))
    return tasksF
  }

  /**
   * 查询农田详情
   * @param id
   * @returns
   */

  async getTaskById(id: number) {
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    let result = await this.rdbStore.query(predicates, ['ID', 'NAME', 'temperature', 'airHumidity', 'soilMoisture', 'co2', 'light','mDay','mWeek','mMonth', 'qiDong', 'kaiGua'])
    console.log('testTag', result);
    if (!result.isAtLastRow) {
      result.goToNextRow()
      console.log('testTag', '调试：a');
      try {
        console.log('testTag', '调试：b');
        let id = result.getLong(result.getColumnIndex('ID'))
        console.log('testTag', '调试：c');
        let name = result.getString(result.getColumnIndex('NAME'))
        let temperature = result.getLong(result.getColumnIndex('temperature'))
        let airHumidity = result.getLong(result.getColumnIndex('airHumidity'))
        let soilMoisture = result.getLong(result.getColumnIndex('soilMoisture'))
        let cO2 = result.getLong(result.getColumnIndex('co2'))
        let light = result.getLong(result.getColumnIndex('light'))
        let mDay = result.getLong(result.getColumnIndex('mDay'))
        let mWeek = result.getLong(result.getColumnIndex('mWeek'))
        let mMonth = result.getLong(result.getColumnIndex('mMonth'))
        let qiDong = result.getString(result.getColumnIndex('qiDong'))
        let kaiGua = result.getLong(result.getColumnIndex('kaiGua'))
        let farmLand: Farmland = new Farmland(id, name, temperature, airHumidity, soilMoisture, cO2, light,!!mDay,!!mWeek,!!mMonth, qiDong,!!kaiGua)
        console.log('testTag', '查询农田详情成功')
        console.log('testTag', '查询到数据：', JSON.stringify(farmLand))
        return farmLand
      } catch (e) {
        console.log('testTag', `农田详情${e}`)
      }
    }
  }
  /**
   * 添加一个新的任务
   * @param name 任务名称
   * @returns 任务id
   */
  addTask(name: string, temperature: number, airHumidity: number, soilMoisture: number, cO2: number, light: number): Promise<number> {
    return this.rdbStore.insert(this.tableName, {
      name,
      temperature,
      airHumidity,
      soilMoisture,
      cO2,
      mday: false,
      mweek: false,
      mmonth: false,
      light,
      kaiGua: false
    })
  }

  /**
   * 根据id更新农田任务状态
   * @param id 任务id
   * @param finished 任务是否完成
   */
  updateTaskStatus2(id: number, qiDong: string) {
    // 1.要更新的数据
    let data = { qiDong }
    // 2.更新的条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    // 3.更新操作
    return this.rdbStore.update(data, predicates)
  }

  updateTaskStatus1(id: number, mday: boolean, mweek: boolean, mmonth: boolean, qiDong: string, kaiGua: boolean) {
    // 1.要更新的数据
    let data = {
      mday,
      mweek,
      mmonth,
      qiDong,
      kaiGua
    }
    // 2.更新的条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    // 3.更新操作
    return this.rdbStore.update(data, predicates)
  }

  updateTaskStatus(id: number, kaiGua: boolean) {
    // 1.要更新的数据
    let data = { kaiGua }
    // 2.更新的条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    // 3.更新操作
    return this.rdbStore.update(data, predicates)
  }

  /**
   * 根据id删除任务
   * @param id 任务id
   */
  deleteTaskById(id: number) {
    // 1.删除的条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    // 2.删除操作
    return this.rdbStore.delete(predicates)
  }
}

export default new TaskModel();

