﻿using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace milano.DTO
{
    public class BillInfo
    {
        public BillInfo(int id, int billID, int foodID, int count)
        {
            this.ID = id;
            this.BillID = billID;
            this.FoodID = foodID;
            this.Count = count;
        }


        public BillInfo(DataRow row)
        {
            this.ID = (int)row["id"];
            this.BillID = (int)row["billID"];
            this.FoodID = (int)row["foodID"];
            this.Count = (int)row["count"];
        }

        private int count;

        public int Count 
        { 
            get => count; 
            set => count = value; 
        }

        private int foodID;

        public int FoodID 
        { 
            get => foodID; 
            set => foodID = value; 
        }

        private int billID;

        public int BillID 
        { 
            get => billID; 
            set => billID = value; 
        }



        private int iD;

        public int ID 
        { 
            get => iD; 
            set => iD = value; 
        }

    }
}
