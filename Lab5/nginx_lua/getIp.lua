#调用shell
local function excute_cmd(cmd)
    local t = io.popen(cmd)
    local ret = t:read("*all")
    return ret
end

local function get_system_info()
    if system_info == nil or system_info == "" then
        local cmd = "top -bn 2 -i -c -d 0.1"
        local output = excute_cmd(cmd)
        -- top result fisrt line is not correct on linux, use second line
        local i, j = string.find( output, "%s\ntop.*" )
        local ret = string.sub(output, i, j)
        system_info = ret
    end
end

local function string_match(str, patten)
    local i, j = string.find(str, patten)
    local ret = string.sub(str, i, j)
    return ret
end

local function string_match_num(str, patten)
    local ret = string_match(str,patten)
    local i, j = string.find(ret, "[0-9]+%.*[0-9]*")
    local num = string.sub(ret, i, j)
    return num
end

#监控cpu
local function get_cpu_usage()
    local cpu_user = string_match_num(system_info, "[0-9]+%.?[0-9]*%sus,")
    local cpu_system = string_match_num(system_info, "[0-9]+%.?[0-9]*%ssy,")
    local cpu_nice = string_match_num(system_info, "[0-9]+%.?[0-9]*%sni,")
    local cpu_idle = string_match_num(system_info, "[0-9]+%.?[0-9]*%sid,")
    local cpu_wait = string_match_num(system_info, "[0-9]+%.?[0-9]*%swa,")
    local cpu_hardware_interrupt = string_match_num(system_info, "[0-9]+%.?[0-9]*%shi,")
    local cpu_software_interrupt = string_match_num(system_info, "[0-9]+%.?[0-9]*%ssi,")
    local cpu_steal_time = string_match_num(system_info, "[0-9]+%.?[0-9]*%sst")

    local cpu_total = cpu_user + cpu_nice + cpu_system + cpu_wait + cpu_hardware_interrupt + cpu_software_interrupt + cpu_steal_time + cpu_idle
    local cpu_time = cpu_user + cpu_nice + cpu_system + cpu_wait + cpu_hardware_interrupt + cpu_software_interrupt + cpu_steal_time

    local cpu_usage = time / total

    return cpu_usage
end

#监控内存
local function get_mem_usage()
    local mem_total = string_match_num(system_info, "Mem[%d%p%s]*[0-9]+%stotal")
    local mem_used = string_match_num(system_info, "free[%d%p%s]*[0-9]+%sused")
    local mem_usage = mem_used  / mem_total
    return mem_usage
end

#将CPU、内存监控内容定向输入test.log文件
file = io.open("/home/noah/test.log", "a")
io.output(file)
io.write(os.date() );
io.write("CPU utilization:"+get_cpu_usage())
io.write("memory utilization:"+get_mem_usage())
io.close(file)

#根据cpu利用率动态分配HTTP请求，假如cpu利用率大于80%，则请求转向另一台虚拟机上的mongo服务，另一台虚拟机上的动态分配将两个IP地址置换，条件不变
if(get_cpu_usage()>0.8)
then
    return 192.168.209.132
else
    return 192.168.209.131
end
