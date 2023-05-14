#!/usr/bin/env python3
import argparse
import csv
from ipaddress import IPv4Network, IPv6Network
import math


class Node:
    def __init__(self, cidr, parent=None):
        self.cidr = cidr
        self.child = []
        self.dead = False
        self.parent = parent

    def __repr__(self):
        return "<Node %s>" % self.cidr

def dump_tree(lst, ident=0):
    for n in lst:
        print("+" * ident + str(n))
        dump_tree(n.child, ident + 1)

def dump_addresslist(lst, f):
    for n in lst:
        if n.dead:
            continue

        if len(n.child) > 0:
            dump_addresslist(n.child, f)
        elif not n.dead:
            f.write('add list=noCN address=' + str(n.cidr) + '\n')
            

def subtract_cidr(sub_from, sub_by):
    for cidr_to_sub in sub_by:
        for n in sub_from:
            if n.cidr == cidr_to_sub:
                print(n.cidr)
                print(cidr_to_sub)
                n.dead = True
                break
            
            #判断是否是超网
            #a = ip_network('192.168.1.0/24')
            #b = ip_network('192.168.1.128/30')
            #a.supernet_of(b)
            #True
            if n.cidr.supernet_of(cidr_to_sub):
                if len(n.child) > 0:
                    subtract_cidr(n.child, sub_by)

                else:
                    #排除网络
                    #n1 = ip_network('192.0.2.0/28')
                    #n2 = ip_network('192.0.2.1/32')
                    #list(n1.address_exclude(n2)) 
                    #[IPv4Network('192.0.2.8/29'), IPv4Network('192.0.2.4/30'),
                    #IPv4Network('192.0.2.2/31'), IPv4Network('192.0.2.0/32')]
                    n.child = [Node(b, n) for b in n.cidr.address_exclude(cidr_to_sub)]

                break

root = [
        IPv4Network('192.168.0.0/16'),
         ]


with open("china_ip_list.txt") as f:
    for line in f:
        if ":" not in line:
            line = line.strip('\n')
            a = IPv4Network(line)
            root.append(a)



with open("CN.rsc", "w") as f:
    f.write('/ip firewall address-list\n')
    f.write('remove [/ip firewall address-list find list=CN]\n')
    for l in root:
        f.write('add list=CN address=' + str(l) + '\n')
    f.write('/\n')
    f.write('/file remove CN.rsc\n')


