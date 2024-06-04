export default class BreakpointConstants{
  /**
   * 小屏幕设备的 BREAKPOINTS 标记
   */
  static readonly BREAKPOINT_SM: string = 'sm';

  /**
   * 中等屏幕设备的 BREAKPOINTS 标记
   */
  static readonly BREAKPOINT_MD: string = 'md';

  /**
   * 大屏幕设备的 BREAKPOINTS 标记
   */
  static readonly BREAKPOINT_LG: string = 'lg';

  /**
   * 当前设备的 breakpoints 存储key
   */
  static readonly CURRENT_BREAKPOINT: string = 'currentBreakpoint';

  /**
   * 小屏幕设备的宽度范围
   */
  static readonly RANGE_SM: string = '(320vp<=width<680vp)';

  /**
   * 中屏幕设备的宽度范围
   */
  static readonly RANGE_MD: string = '(680vp<=width<840vp)';

  /**
   * 大屏幕设备的宽度范围
   */
  static readonly RANGE_LG: string = '(840vp<=width)';



}