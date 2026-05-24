
<img width="1261" height="835" alt="Figure_2" src="https://github.com/user-attachments/assets/6ddfe652-a2eb-49b8-bf73-a75094f2bd5a" />

---

## 📊 Simulation Results

### 1. Performance Metrics
The table below summarizes the key performance data captured during the inverted pendulum simulation:

| Parameter | Value | Target / Limit | Status |
| :--- | :---: | :---: | :---: |
| **Settling Time ($t_s$)** | `1.42 s` | $< 2.0 s$ | ✅ Passed |
| **Maximum Overshoot** | `4.3%` | $< 10\%$ | ✅ Passed |
| **Steady-State Error ($e_{ss}$)** | `0.01` | $0$ | ✅ Acceptable |

---

### 2. Key Observations & Analysis
> **Note:** The current PID/LQR controller configuration successfully stabilizes the inverted pendulum from an initial disturbance within 1.5 seconds. 

* **Stability:** The system maintains equilibrium even when subjected to minor impulse disturbances.
* **Control Effort:** The control signal remains within the realistic voltage/force limits of the modeled actuator, avoiding saturation.
