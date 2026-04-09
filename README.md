# memory -design -verilog
Parameterized memory (RAM) design in Verilog with synchronous read/write, handshake protocol (valid-ready), and comprehensive testbench.
# Memory Design in Verilog (RAM Model)

## 📌 Overview

This project implements a parameterized memory module in Verilog with support for read and write operations using a simple handshake protocol.

## ⚙️ Features

* Parameterized WIDTH and DEPTH
* Synchronous memory design
* Read/Write control using `wr_rd`
* Handshake using `valid` and `ready`
* Memory initialization during reset
* Supports file-based memory operations using `$readmemh` and `$writememh`

## 🧠 Design Details

* `wr_rd = 1` → Write operation
* `wr_rd = 0` → Read operation
* `valid` → Request signal
* `ready` → Acknowledgment signal

## 📂 Files

* `memory.v` → Memory module
* `memory_tb.v` → Testbench with multiple test cases

## 🧪 Test Cases Implemented

* Single Write & Read
* Multiple Write & Read
* Front Door Write & Read
* Back Door Write & Read
* Quarter Memory Testing
* Consecutive Read/Write Operations
* File-based Read/Write (`input.hex`, `output.hex`)

## ▶️ How to Run

1. Compile:

   ```
   vlog memory.v memory_tb.v
   ```

2. Run simulation:

   ```
   vsim memory_tb +test_name=1WR_1RD
   ```

3. View waveform:

   ```
   add wave *
   run -all
   ```

## 🛠 Tools Used

* ModelSim / QuestaSim
* Verilog HDL

## 📸 Output

* Waveforms showing read/write operations
* Memory dump using `.hex` files

## 💡 Future Improvements

* Add asynchronous read
* Add byte-enable support
* Convert to dual-port RAM
* Add error handling

## 👩‍💻 Author

ECE Graduate | VLSI Enthusiast(DESIGN & VERIFICATION)
