import { getFullnodeUrl } from "@mysten/sui/client";
import { createNetworkConfig } from "@mysten/dapp-kit";

const { networkConfig, useNetworkVariable, useNetworkVariables } =
  createNetworkConfig({
    devnet: {
      url: getFullnodeUrl("devnet"),
      variables: {
        packageId: "0x0",
        mintAddresses: "0x0",
      },
    },
    testnet: {
      url: getFullnodeUrl("testnet"),
      variables: {
        packageId: "0xb92e895a1670c99a7a1b589753faeb00f48adfe091ca11790294414a5c2f21b4", 
        mintAddresses: "0x5c364c1e7ddfe158ba6e0331179680d0b163fbdb1d02383046efbde2aa7d60bc" 
      },
    },
    mainnet: {
      url: getFullnodeUrl("mainnet"),
      variables: {
        packageId: "0x0",
        mintAddresses: "0x0",
      },
    },
  });

export { useNetworkVariable, useNetworkVariables, networkConfig };
