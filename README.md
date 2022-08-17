<div align="center">
  <h1 align="center"> Squeeth Vol Oracle</h1>

<p align='center'>
    <!-- pics go here -->
    <img src='https://i.imgur.com/Qf6Ga0N.jpg' alt='squeeth' width="280" />
</p> 
<a href="https://github.com/antoncoding/vol-oracle/actions/workflows/CI.yml"><img src="https://github.com/antoncoding/vol-oracle/workflows/CI/badge.svg"> </a>

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

```shell
forge script scripts/Deploy.sol --private-key <private key> --fork-url <mainnet rpc>
```

Output:

```shell
== Logs ==
  implied funding:    2444635075033974
  implied volatility: 944611985096208966

```

### Contract Interface

```solidity
function getEthTwaIV(uint256 secondsAgo) external view returns (uint256 vol);

function getImpliedFunding(uint32 secondsAgo) external view returns (uint256 impliedFunding);

```
