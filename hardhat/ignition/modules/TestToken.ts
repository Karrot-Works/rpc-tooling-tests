import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const TestTokenModule = buildModule("TestTokenModule", (m) => {
    const initialSupply = m.getParameter("initialSupply", 1_000_000n);

    const token = m.contract("TestToken", [initialSupply]);

    return { token };
});


export default TestTokenModule;
