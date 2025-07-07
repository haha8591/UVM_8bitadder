# UVM_8bitadder
建構UVM平台驗證8bit加法器

![image](https://github.com/user-attachments/assets/e86c46a8-98e1-4d0d-acb7-30972d2f7366)
![image](https://github.com/user-attachments/assets/c0378a95-ffc3-4100-badc-a5115a154070)


dut不屬於UVM的component, 會透過testbench 的 top module 實例化
而top_tb裡面會運行run_test() 決定要執行哪個test並建構驗證平台
![image](https://github.com/user-attachments/assets/c32ef825-b273-4e37-95fc-4e2c88517740)



但run_test()只能實例化一個實例, 這樣其他component無法實例化
所以run_test()要實例化一個容器類,然後在這個容器下面實例化其他component(driver、monitor...)
![image](https://github.com/user-attachments/assets/60553cc9-daa9-4feb-bfcb-29e82375fe4d)



transaction 是封裝成物件的一筆資料，代表一次 stimulus ，用來驅動 DUT 或比對結果
其他元件（如 sequence、driver、monitor）都會用到，因此最先定義。
rand bit 生成隨機的input data

![image](https://github.com/user-attachments/assets/8c34866e-1597-4ae4-8930-3b0a5d8b9952)



sequence 裝了多個transaction的uvm_obj, 產生transaction
在UVM實戰這本書中將sequence比喻為彈匣, transaction就是子彈

![image](https://github.com/user-attachments/assets/29a7654f-e450-4e82-89b7-a7cda0bcd5db)



sequencer是一個UVM component, 把transaction傳給driver
driver是一個UVM component, 驅動transaction給dut, 把原本transaction轉成dut要的訊號

![image](https://github.com/user-attachments/assets/522f5a57-9af3-4725-924d-6ae60d0a72fb)



![image](https://github.com/user-attachments/assets/a90ae353-173b-440a-9b91-1c3538c48fbc)



![image](https://github.com/user-attachments/assets/b6a572dc-32b7-4fde-82b3-4f500f4793aa)



![image](https://github.com/user-attachments/assets/979f3484-7d72-4551-9c75-bf90e3e9b5dc)



![image](https://github.com/user-attachments/assets/d4f2763a-8545-40e1-86dd-f36b19b1da07)



![image](https://github.com/user-attachments/assets/50aa3563-9fc6-442a-814e-6fe519878a43)



在QuestaSim下進行波型模擬和驗證
![image](https://github.com/user-attachments/assets/3ea9ca41-8260-4e6c-96a5-4ec6a1cc6110)
![image](https://github.com/user-attachments/assets/1946e052-1744-43ce-8d52-f233b3b32c70)
![image](https://github.com/user-attachments/assets/e7a7d099-3cd3-4d7a-9e28-39d48932874b)



此專案在windows平台下進行, 有撰寫.bat檔可以動態生成TCL
只要雙擊start_questa 輸入要驗證的test name, 會自動打開QuestaSim進行驗證並進行波型模擬

未來繼續加強的部分
驗證更複雜的電路(AXI protocol、CPU...)
在電路加入錯誤的部分，看平台是否能驗出
加入constraint、coverage


reference: UVM實戰
