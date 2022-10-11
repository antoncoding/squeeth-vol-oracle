<div align="center">
  <h1 align="center"> Squeeth Vol Oracle</h1>

<p align='center'>
    <!-- pics go here -->
    <img src='https://i.imgur.com/Qf6Ga0N.jpg' alt='squeeth' width="350" />
</p> 
<a href="https://github.com/antoncoding/squeeth-vol-oracle/actions/workflows/CI.yml"><img src="https://github.com/antoncoding/squeeth-vol-oracle/workflows/CI/badge.svg"> </a>

<h6 align="center"> Built with <a href="https://github.com/foundry-rs/forge-template"> foundry template</a>

</div>

## Getting Started

Compile and run tests

```sh
forge build

forge test
```

### Using the contract

The contract is still in development phase and not yet deployed. But you can already stimulate the gas cost and result of the current mainnet state with foundry script:

```shell
forge script scripts/Deploy.sol --fork-url <mainnet rpc>
```

### Deployment

Run the script to deploy your own contract instance on mainnet.

```shell
forge script scripts/Deploy.sol --fork-url <mainnet rpc> --broadcast --verify -vvvv
```

Output:

```shell
== Logs ==
  implied volatility: 959347350657613352
  gas cost:           97612
  implied funding:    2521499559489813

```

#### Gas Cost

The gas cost is around 46K ~ 140K, depends on:

- `secondsAgo` to calculate twap
- current state of Uniswap pool, how many records are in the last `secondsAgo` seconds

It costs least (around 46K) while querying the implied vol by the current spot price.

### Contract Interface

```solidity
/// @dev return implied vol with 18 decimals (1e18 = 100%)
function getEthTwaIV(uint256 secondsAgo) external view returns (uint256 vol);

/// @dev return daily implied funding with 18 decimals (1e18 = 100%)
function getImpliedFunding(uint32 secondsAgo) external view returns (uint256 impliedFunding);

```
