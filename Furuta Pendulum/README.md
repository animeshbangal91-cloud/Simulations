# Furuta Inverted Pendulum Simulation and PD Stabilization

This project simulates a **Furuta pendulum**, also known as a **rotary inverted pendulum**, in MATLAB. The system consists of a rotary arm driven by a motor and a pendulum attached at the end of the arm. The Furuta pendulum is a classic nonlinear and underactuated control system.

The project implements the nonlinear equations of motion and applies a **PD/state-feedback controller** to stabilize the pendulum around the upright equilibrium position.

## Result

The pendulum is initialized close to the upright position and stabilized using a PD controller.

## System Convention

The model follows the angle convention used in the reference paper:

- `theta1` = rotary arm angle
- `theta2` = pendulum angle
- `theta2 = 0` = pendulum hanging downward
- `theta2 = pi` = pendulum upright

The state vector is:

```matlab
x = [theta1;
     theta2;
     theta1dot;
     theta2dot];
```
## Results

### Raw Angle Response

The plot below shows the rotary arm angle `theta1` and pendulum angle `theta2` during upright stabilization.  
Since the model follows the paper convention, `theta2 = 180 deg` corresponds to the upright position.

<img width="1144" height="741" alt="Figure_1" src="https://github.com/user-attachments/assets/37d2232a-80d4-4f91-abef-24b57055e7cc" />

### Pendulum Error from Upright

The plot below shows the pendulum error relative to the upright position. The controller drives the error close to zero.

<img width="1150" height="759" alt="Figure_2" src="https://github.com/user-attachments/assets/29c52eb6-fb80-4e51-9e89-679427047cd7" />

## Reference

The nonlinear dynamics used in this project are based on the following research paper:

B. S. Cazzolato and Z. Prime, “On the Dynamics of the Furuta Pendulum,” Journal of Control Science and Engineering, vol. 2011, Article ID 528341, 2011.

DOI: 10.1155/2011/528341

## Future Improvements

- Add an energy-based swing-up controller
- Switch automatically from swing-up control to PD stabilization near upright
- Add an LQR controller
- Compare PD and LQR performance
- Add motor voltage and current dynamics
- Add torque limits based on a real DC motor
- Add Coulomb friction and more realistic damping
- Add animation of the Furuta pendulum motion
- Export simulation results to CSV
- Implement the same simulation in Python
- Compare MATLAB simulation results with a real Furuta pendulum setup
