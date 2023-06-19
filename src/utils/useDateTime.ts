// 格式化时间
/**
 * 使用：
 * TimeFormat() // 默认返回当前时间 yyyy-mm-dd
 * TimeFormat('yyyy-mm-dd hh:ii') // 默认返回当前时间 自定义格式
 * TimeFormat('yyyy/mm/dd hh:ii:ss', 1554954127000) // 返回传入时间戳的格式化时间
 */
export const timeFormat = (type: string = 'yyyy-mm-dd', d?: string | Date | number): string => {
    const date = d ? new Date(d) : new Date();

    const o: { [key: string]: number } = {
        'm+': date.getMonth() + 1, // 月份
        'd+': date.getDate(), // 日
        'h+': date.getHours(), // 小时
        'i+': date.getMinutes(), // 分
        's+': date.getSeconds(), // 秒
    };

    let formattedTime = type.replace(/(y+)/, ($0: string) => {
        return (date.getFullYear() + '').slice(-$0.length);
    });

    for (const key in o) {
        if (new RegExp('(' + key + ')').test(type)) {
            const value = o[key];
            formattedTime = formattedTime.replace(new RegExp(key, 'g'), ($0: string) => {
                return ($0.length === 1) ? value.toString() : ('00' + value).slice(-$0.length);
            });
        }
    }

    return formattedTime
}

