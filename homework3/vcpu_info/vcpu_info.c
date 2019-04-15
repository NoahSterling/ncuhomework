#include<linux/kernel.h>
#include<linux/syscalls.h>
#include<linux/init.h>
#include<linux/linkage.h>
#include "vcpu_info.h"
#include<uapi/linux/kvm_para.h>
#include<linux/cpumask.h>

long vcpu_info(void)
{
        int id;
        for_each_online_cpu(id) {
                kvm_hypercall1(KVM_HC_VCPU_INFO, id);
        }
        return 0;
}

asmlinkage long sys_vcpu_info(void)
{
        return vcpu_info();
}

