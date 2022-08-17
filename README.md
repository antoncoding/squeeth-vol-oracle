<div align="center">
  <h1 align="center"> Squeeth Vol Oracle 🥂</h1>
  <a href="https://github.com/antoncoding/vol-oracle/actions/workflows/CI.yml"><img src="https://github.com/antoncoding/vol-oracle/workflows/CI/badge.svg"> </a>

<p align='center'>
    <!-- pics go here -->
    <!-- <img src='' alt='' width="500" /> -->
</p>  
<h6 align="center"> Built with <a href="https://github.com/foundry-rs/forge-template"> foundry template</a>

</div>

## Getting Started

Compile and run tests

```sh
forge build

forge test
```

### Using the contract

The contract is still in development phase and not yet deployed. But you can already stimulate the real-world result of getting vol with foundry script:

```
forge script scripts/Deploy.sol --private-key <private key> --fork-url <mainnet rpc> --ffi -vvv
```

### Contract Interface

```solidity
function getEthTwaIV(uint256 secondsAgo) external view returns (uint256 vol);

function getImpliedFunding(uint32 secondsAgo) public view returns (uint256 impliedFunding);

```
