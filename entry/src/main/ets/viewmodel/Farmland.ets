/**
 * 农田数据类型
 */
@Observed
export default class Farmland {
  /**
   * 农田编号
   */
  id: number

  /**
   * 农田名称
   */
  name: string

  /**
   * 温度
   */
  temperature: number

  /**
   * 空气湿度
   */
  airHumidity: number

  /**
   * 土壤湿度
   */
  soilMoisture: number

  /**
   * 二氧化碳
   */
  cO2: number

  /**
   * 光照
   */
  light: number

  /**
   * 每日
   */
  mDay: boolean

  /**
   * 每周
   */
  mWeek: boolean

  /**
   * 每月
   */
  mMonth: boolean

  /**
   * 开始时间（当前时间时间戳+(当前时间时间戳-设置的时间的戳)=启动时间）
   */
  qiDong: string

  /**
   * 阀门开关
   */
  kaiGua: boolean

  constructor(id: number, name: string, temperature: number, airHumidity: number, soilMoisture: number, cO2: number, light: number,mDay: boolean, mWeek: boolean, mMonth: boolean,qiDong: string,kaiGua:boolean) {
    this.id = id
    this.name = name
    this.temperature = temperature
    this.airHumidity = airHumidity
    this.soilMoisture = soilMoisture
    this.cO2 = cO2
    this.light = light
    this.mDay = mDay
    this.mWeek = mWeek
    this.mMonth = mMonth
    this.qiDong = qiDong
    this.kaiGua = kaiGua
  }
}