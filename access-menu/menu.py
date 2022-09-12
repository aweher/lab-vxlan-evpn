#!/usr/bin/env python3

import os
from clint.textui import colored
from colorama import Fore, Back, Style
from pyfiglet import Figlet
import subprocess

class LabMenu(object):
    def __init__(self):
        self.cant_asientos = 50
        self.asientos = []
        self.mi_asiento = "0"
        self.allowed_devices = ["1", "2", "q"] # 1 = leaf, 2 = host

        self.name_prefixes = {
            "leaf": "lacnog2022-vxlan-evpn-leaf",
            "host": "lacnog2022-vxlan-evpn-host"
            }

        # Init some values
        for j in range(1, self.cant_asientos+1):
            self.asientos.append(str(j))
        self.asientos.append("q")
    
    def banner(self, text):
        result = Figlet()
        return colored.cyan(result.renderText(text))
    
    def show(self):
        choice = 'abc'
        while choice not in self.asientos:
            os.system("clear")
            print(self.banner("LACNOG 2022"))
            print(f"Input your Group Number (1 to {self.cant_asientos}), q to exit")
            choice = input("\n> ")
        if choice.lower() == "q":
            self.good_bye()
        self.mi_asiento = choice
        self.show_connection_menu()
    
    def show_connection_menu(self):
        os.system("clear")
        print(self.banner(f"SEAT {self.mi_asiento}"))
        device = 'abc'
        while device not in self.allowed_devices:
            print("Select the device you want to connect to:")
            print("1 = LEAF")
            print("2 = HOST")
            print("\n")
            print("q = Exit")
            device = input("\n> ")

            if device == '1':
                # Connect to Leaf
                print(Fore.GREEN + f"Connecting to LEAF{self.mi_asiento}")
                print(Style.RESET_ALL)
                
                p = subprocess.run(f"docker exec -ti {self.name_prefixes['leaf']}{self.mi_asiento} ash", shell=True, text=True, stderr=subprocess.PIPE)
                if p.returncode is not 0:
                    print(Fore.RED + f"Something failed...:(\n{p.stderr}")
                    print(Style.RESET_ALL)
                    os.system("pause")

            elif device == '2':
                # Connect to host
                print(Fore.GREEN + f"Connecting to HOST{self.mi_asiento}")
                print(Style.RESET_ALL)

                p = subprocess.run(f"docker exec -ti {self.name_prefixes['leaf']}{self.mi_asiento} ash", shell=True, text=True, stderr=subprocess.PIPE)
                if p.returncode is not 0:
                    print(Fore.RED + f"Something Failed...:(\n{p.stderr}")
                    print(Style.RESET_ALL)
                    os.system("pause")
            
            elif device == "q":
                self.good_bye()
            self.show_connection_menu()
    
    def good_bye(self):
        print(Fore.YELLOW + f"Have a nice day...")
        print(Style.RESET_ALL)
        exit()